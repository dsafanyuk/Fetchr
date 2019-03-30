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
    <div col-md-6>

      <div class="card-box" >

        <!-- Order Details -->
        <div class="text-xs-left">
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



        <div class="chat-conversation"  style="max-height:300px;"   id="chat-conversation"  ref="chatContainer">
                <ul class="conversation-list"  tabindex="5001" >
                    <li  v-for="message in chatMessages" class="clearfix"   v-bind:class="displayMessages(message.SenderId)">

                        <div class="conversation-text" >
                            <div class="ctext-wrap">
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
                              <img v-else width="24" height="24" src="https://cdn.vuetifyjs.com/images/logos/v-alt.svg" alt="">
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

      }
    },
    props: [
      'id'
    ],
    created(){
    },
    mounted () {
      this.fetchMessages()
      this.scrollToEnd();
    },
    updated ()
    {
      this.scrollToEnd();
    },
    components: {
      'chatroom': ChatRoom,
      'OrderDetailsChat': OrderDetailsChat,
    },
    computed: {

      messages () {
        return this.chatMessages
      },
    },
    methods: {
      scrollToEnd() {
				var container = document.querySelector(".chat-conversation");
				var scrollHeight = container.scrollHeight;
				container.scrollTop = scrollHeight;
			},

      sendMessage () {
        if (this.content !== '') {
      const  Message_data = {
        OrderId  : parseInt(this.$route.params.order_id),
        ReceiverId: browserCookies.get("current_receiver"),
        SenderId :  browserCookies.get("user_id"),
        Content : this.content
      }
          this.$store.dispatch('sendMessage', Message_data)
          this.content = '' // Clear after You send the Message
        }
      },

      fetchMessages() {
        this.isChatLoading = true;
        let orderId = parseInt(this.$route.params.order_id)
        let refmessages = firebase.database().ref('messages').orderByChild('OrderId').equalTo(orderId).limitToLast(20)
        let temp_data = []
        refmessages.on("child_added", function(snapshot) {
          var data = snapshot.val()
          temp_data.push(data)


        })
        this.chatMessages = temp_data

        this.scrollToEnd()
      },
      // Messages Left & right
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

<style>
@import "../../../assets/courier/css/core.css";
@import "../../../assets/courier/css/components.css";
.conversation-text{
  padding-bottom: 10px !important;
}
.mymessage {
  text-align: right;
  color: #344955;
}
.mymessage .ctext-wrap{
  color : white;
  background: #34d3eb
}
.chat-conversation{
width: 600px;
max-height: 300px;
overflow: scroll;
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
