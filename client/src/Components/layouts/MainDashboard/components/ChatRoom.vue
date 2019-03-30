<template>
  <v-card>


    <v-list subheader>
      <v-subheader>Recent orders</v-subheader>
      <v-list-tile
        v-for="(chat, index) in chats"
        :key="chat.order_id"
        avatar
        @click="loadChatRoom(chat.order_id,chat.receiver_id)"
      >
        <v-list-tile-avatar>
          <v-icon>perm_identity</v-icon>
        </v-list-tile-avatar>

        <v-list-tile-content
        >
          <v-list-tile-title >{{"# "+ chat.order_id + "-" + chat.userInfo }}</v-list-tile-title>
        </v-list-tile-content>

        <v-list-tile-action>
          <v-icon>chat_bubble</v-icon>
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
  export default{
    data () {
      return {
        recentChats: 'Recent Chats',
        orders : {},
        avatar: 'https://cdn.vuetifyjs.com/images/lists/4.jpg',

      }
    },
    created () {
      // Get all the orderId where the current user is involved
      axios
        .get("/api/users/" + browserCookies.get("user_id") + "/orderschat")
        .then(response => {

          this.$store.dispatch ('loadChats', {orders : response.data})
        });

    },
    computed: {
      chats () {

        return  this.$store.getters.chats

      }
    },
    methods :{
      loadChatRoom: function(order_id, receiver_id) {
        this.$router.push("/chat/" + order_id);
        this.$emit('fetchMessages')


      }


    }
  }
</script>

<style scoped="true">
@import "../../../assets/courier/css/core.css";
@import "../../../assets/courier/css/components.css";
</style>
