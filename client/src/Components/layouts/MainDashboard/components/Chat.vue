<template>
  <body >

  <v-layout row class="chat_container" >
    <loading :active.sync="isChatLoading"
             :is-full-page="fullPage"
             :can-cancel="true"
             :on-cancel="onCancel"

            >
    </loading>
    <v-flex xs12 sm3 md3 offset-sm1>
      <chatroom @fetchMessages="fetchMessages" model="fullPage"> </chatroom>
    </v-flex>
    <div col-md-6 style="margin-left: 20px">

      <div class="card-box" >

        <!-- Order Details -->
        <div class="text-xs-left col-md-6">
     <v-dialog
       v-model="ORDER_DETAILS_DIALOG"
       width="500"
     >
       <template v-slot:activator="{ on }">
         <v-btn
           color="#344955"
           dark
           v-on:click="showOrderDetails"
         >
           Order Details
         </v-btn>
               <v-divider></v-divider>
       </template>

       <v-card>
         <OrderDetailsChat :items ="items" :total = "total" > </OrderDetailsChat>
       </v-card>
     </v-dialog>
   </div>
<!-- End Of Order Details -->


  </v-flex>



        <div class="chat-conversation"     id="chat-conversation"  ref="chatContainer">
                <ul class="conversation-list"  tabindex="5001" >
                    <li  v-for="message in chatMessages" class="clearfix"   v-bind:class="displayMessages(message.SenderId)">

                        <div class="conversation-text" style="width: 100%; margin-left: 0px">
                            <div class="ctext-wrap" style="font-size: 16px">
                                <p v-html="message.Content"> </p>
                            </div>
                        </div>
                    </li>
                </ul>

            </div>
            <v-layout row wrap>
                      <v-flex xs12>
                        <v-text-field
                          outline
                          clearable
                          placeholder="Type Your Message Here "
                          type="text"
                          v-on:keyup.enter="sendMessage"
                          v-model="content"
                        >

                          <template v-slot:append>
                            <v-fade-transition leave-absolute>
                              <v-progress-circular
                                v-if="loading"
                                size="24"
                                color="info"
                                indeterminate
                              ></v-progress-circular>
                            <a v-on:click="sendMessage"><v-icon>send</v-icon></a>
                            </v-fade-transition>
                          </template>
                          <template v-slot:append-outer>
                            <v-menu
                              style="top: -12px"
                              offset-y
                            >

                            </v-menu>
                          </template>
                        </v-text-field>
                      </v-flex>


                    </v-layout>
      </div>

    </div>
</v-layout>


</body>
</template>

<script>
  import ChatRoom from './ChatRoom.vue'
  import OrderDetailsChat from "./ChatOrderDetails.vue"
  import * as firebase from 'firebase'
  import browserCookies from "browser-cookies";
  import axios from "../../../../axios";
  import Loading from 'vue-loading-overlay';
  import 'vue-loading-overlay/dist/vue-loading.css';

  export default {
    data () {
      return {
        content: '',
        chatMessages: [],
        loading: false,
        currentChatRoom : null,
        items: [],
        total: 0.0,
        ORDER_DETAILS_DIALOG : false,
        isChatLoading: false,
        fullPage: true,
        senderFirstName: browserCookies.get('first_name'),
      }
    },
    props: [
      'id'
    ],
    created () {
      this.$store.dispatch('clearchats')
      this.fetchMessages()

    },
    mounted (){
      // Clear the store before reload
      this.$store.dispatch('clearchats')
    },
    watch: {
      chatMessages: function() {
        if (this.chatMessages.length == 1 || this.chatMessages.length == 0)
        {
        this.scrollToTop()

        }
        else
        {
          var self = this
           setTimeout(function(){
              self.scrollToEnd()
            }, 100);
        }
      }},
    components: {
      'chatroom': ChatRoom,
      'OrderDetailsChat': OrderDetailsChat,
      'loading' : Loading

    },
    computed: {
    },
    methods: {
      scrollToEnd() {
				var container = document.querySelector(".chat-conversation");
				var scrollHeight = container.scrollHeight;
				container.scrollTop = scrollHeight;


			},
      scrollToTop() {
        var container = document.querySelector(".chat-conversation");
        container.scrollTop = 0;

      },
      sendMessage () {
        if (this.content !== '') {
      const  Message_data = {
        OrderId  : parseInt(this.$route.params.order_id),
        ReceiverId: browserCookies.get("current_receiver_id"),
        SenderId :  browserCookies.get("user_id"),
        Content : this.content
      }
          console.log(this.$store.getters.UserInfo);
          this.$store.dispatch('sendMessage', Message_data)
          this.content = ''
        }
      },

      fetchMessages() {
        this.isChatLoading = true;
        let orderId = parseInt(this.$route.params.order_id)
        let refmessages = firebase.database().ref('messages').orderByChild('OrderId').equalTo(orderId).limitToLast(100)
        let temp_data = []
        var self = this
        refmessages.on("child_added", function(snapshot) {

          self.isChatLoading = false;
          var data = snapshot.val()
          temp_data.push(data)
        })

        this.chatMessages = temp_data
        //If there's no chat for the current id
        self.isChatLoading = false;
        refmessages = null;

      },
      displayMessages(SenderId)
      {
        if( SenderId == browserCookies.get("user_id") )
          return "mymessage"
      },
      getFullName (id)
      {
        axios
        .get("/api/users/" + id +  "/showInfo")
        .then(response => {
            fullname = response.data[0]['first_name'] + " " + response.data[0]['last_name']
            console.log(fullname);
            chatList.push({chat_key : temp_chat_key,
            sender_id : temp_sender_id,
             receiver_id :temp_receiver_id,
             order_id : snapshot.val()[temp_chat_key]['order_id'],
             userInfo : temp_fullInfo
            })

        });
      },
      isOrderExist()
      {
        axios
        .get("/api/orders/" + this.$route.params.order_id +  "/showInfo")
        .then(response => {
        });
      },
      showOrderDetails (){
        this.ORDER_DETAILS_DIALOG = true;
        axios
        .get(`/api/orders/${this.$route.params.order_id}/summary`)
        .then(response => {
          let orderInfo = response.data.orderInfo[0];

          this.items = response.data.productList;
          this.total = 0
          this.items.forEach(item => {
            item.item_total = item.price * item.quantity;
            this.total += item.item_total;
          });
        });


      },
      onCancel ()
      {
        console.log("On CANCEL");
      }

    }
  }
</script>
<style scoped src="../../../assets/courier/css/core.scss"></style>
<style scoped src="../../../assets/courier/css/components.scss"></style>
<style lang="css" scoped>

.conversation-text{
  padding-bottom: 10px !important;
}
.mymessage {
  text-align: right;
  color: #344955;
}
.mymessage .ctext-wrap{
  color : white;
  background: #f9aa33

}
.chat-conversation{
width: 600px;
max-height: 300px;
overflow: scroll;
 overflow-x: hidden;
}
.chat_container{
margin-top: 100px;
}
.message_container{
  width: 600px;
  margin-left: 10px;
}


  .chat-container{
    box-sizing: border-box;
    height: calc(100vh - 9.5rem);
    overflow-y: auto;
    padding: 10px;
    background-color: #f2f2f2;
  }
  .message{
    margin-bottom: 3px;
  }
  .message.own{
    text-align: right;
  }
  .message.own .content{
    background-color: lightskyblue;
  }
  .chat-container .username{
    font-size: 18px;
    font-weight: bold;
  }
  .chat-container .content{
    padding: 8px;
    background-color: lightgreen;
    border-radius: 10px;
    display:inline-block;
    box-shadow: 0 1px 3px 0 rgba(0,0,0,0.2), 0 1px 1px 0 rgba(0,0,0,0.14), 0 2px 1px -1px rgba(0,0,0,0.12);
    max-width: 50%;
    word-wrap: break-word;
    }
  @media (max-width: 480px) {
    .chat-container .content{
      max-width: 60%;
    }
  }
</style>
