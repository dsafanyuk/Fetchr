<template>
  <v-card>


    <v-list subheader>
      <v-subheader>Recent orders</v-subheader>
      <v-list-tile
        v-for="(chat, index) in chats"
        :key="chat.order_id"
        avatar
        :to="'/chat/' + chat.order_id"
        :exact="chats.exact"
        active-class="white--text accent"
        @click="loadChatRoom(chat.order_id,chat.receiver_id)"
      >
        <v-list-tile-avatar>
          <v-icon :color="('/chat/' + chat.order_id) == currPath ? 'white' : 'black'">perm_identity</v-icon>
        </v-list-tile-avatar>

        <v-list-tile-content
        >

          <v-list-tile-title >{{"# "+ chat.order_id + "-" + chat.userInfo }}</v-list-tile-title>
        </v-list-tile-content>

        <v-list-tile-action>
          <v-icon :color="('/chat/' + chat.order_id) == currPath ? 'white' : 'black'">chat_bubble</v-icon>
        </v-list-tile-action>
      </v-list-tile>
    </v-list>

    <v-divider></v-divider>


      </v-list-tile>
    </v-list>
  </v-card>
</template>

<script>
  import browserCookies from "browser-cookies";
  import axios from "../../../../axios";
  import router from "../../../../router"
  export default{
    data () {
      return {
        recentChats: 'Recent Chats',
        orders : {},
        currPath: String,
      }
    },
    created () {
      // Get all the orderId where the current user is involved
      axios
        .get("/api/users/" + browserCookies.get("user_id") + "/orderschat")
        .then(response => {
          this.$store.dispatch ('clearchats')
          .then(() => {
            this.$store.dispatch ('loadChats', {orders : response.data})
          })

        });

    },
    computed: {
      chats () {
        return  this.$store.getters.chats

      },
    },
    mounted (){
      this.$store.dispatch ('clearchats')
    },
    methods :{
      loadChatRoom: function(order_id, receiver_id) {
        //browserCookies.set("current_receiver_id",receiver_id)
        this.currPath = router.history.current.path;
        this.$router.push("/chat/" + order_id);
        this.$emit('fetchMessages')


      }


    }
  }
</script>

<style scoped="true">

</style>
