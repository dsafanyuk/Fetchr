<template>
<div>
  <loading :active.sync="chatloader"
            :can-cancel="true"
            :on-cancel="onCancel"
            :is-full-page="fullPage">
  </loading>

<v-btn   icon slot="default"  @click="isChatExist()"> <v-icon>far fa-comment</v-icon></v-btn>
<v-dialog v-model="dialog" persistent max-width="600px">

  <v-card>
    <v-card-title>
      <span class="headline"> Write a Message to the Courier </span> </v-card-title>
    <v-card-text>
      <v-container grid-list-md>
        <v-layout wrap>

          <v-textarea name="input-7-1" v-model="msg_content" value="" hint="Type Here">
          </v-textarea>
        </v-layout>
      </v-container>
    </v-card-text>
    <v-card-actions>
      <v-spacer>
      </v-spacer>
      <v-btn color="blue darken-1" flat @click="dialog = false"> Close </v-btn>
      <v-btn color="success" @click="createChat()"> Send </v-btn>
      </v-card-actions> </v-card>
</v-dialog>
</div>
</template>
<script>
import Loading from 'vue-loading-overlay';
import 'vue-loading-overlay/dist/vue-loading.css';
import browserCookies from "browser-cookies";
import axios from "../../../../axios";
import {mapActions} from "vuex";
import * as firebase from 'firebase'

export default {
  data() {
    return {
      chatloader : false,
      fullPage: true,
      orders: {},
      dialog: false,
      msg_content: '',
      user_id: browserCookies.get("user_id"),

    };
  },
props : {
  order_id : Number,

},
  components: {
    Loading
},
  methods: {
    createChat: function() {

      axios
      .get("/api/orders/" + this.$props.order_id)
      .then(response => {
      var receiver_id = response.data[0]['courier_id'];
        this.$store.dispatch('createChat',{message: this.msg_content, sender_id : this.user_id, receiver : receiver_id, or_id : this.$props.order_id });
        this.$router.push("/chat/" + this.$props.order_id);
      });

    },

    isChatExist : function (){

      var self = this
      var isexist = false

      self.chatloader = true

      let chatref = firebase.database().ref('messages').orderByChild('OrderId').equalTo(this.$props.order_id)
      chatref.on("value", function(snapshot) {
      if(snapshot.exists())
      {
          self.chatloader = false
          self.$router.push("/chat/"+self.$props.order_id);
      }
      else
      {
          self.chatloader = false
          self.dialog = true
      }
      })

  },
  onCancel : function(){
    console.log(" Loader Cancelled");
  }

  }
};
</script>
<style scope="true">
</style>
