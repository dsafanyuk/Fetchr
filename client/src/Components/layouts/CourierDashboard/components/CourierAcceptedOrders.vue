<template>
  <v-card>
    <div v-if="this.$store.getters['courier/isLoading']">
      <v-progress-linear :indeterminate="true" height="10"></v-progress-linear>
    </div>
    <v-data-table :headers="headers" :items="orders" v-bind:pagination.sync="pagination">
      <template slot="items" slot-scope="props">
        <tr>


          <td @click="toggleDialog(props.item)" >{{props.item.order_id}}</span></td>
          <td @click="toggleDialog(props.item)">{{props.item.first_name}}</td>
          <td @click="toggleDialog(props.item)">{{props.item.room_num}}</td>
          <td @click="toggleDialog(props.item)">{{props.item.time_created}}</td>
          <CreateConversation v-if = "props.item.order_id" :order_id="parseInt(props.item.order_id)"></CreateConversation>
          <td v-else ></td>

        </tr>

      </template>
    </v-data-table>
  </v-card>
</template>

<script>
import CreateConversation from '../../MainDashboard/components/ChatCreateConversation.vue'
export default {
  name: "CourierAvailableOrders",
  data() {
    return {
      pagination: { sortBy: "order_id", descending: true, rowsPerPage: 5 },
      headers: [
        { text: "Order #", align: "left", value: "order_id" },
        { text: "Name", align: "left", value: "first_name" },
        { text: "Room #", align: "left", value: "room_num" },
        { text: "Time Created", align: "left", value: "time_created" }
      ]
    };
  },
  props: {
    orders: Array
  },
  components : {
      'CreateConversation': CreateConversation,
  },
  computed: {},
  methods: {
       toggleDialog(value) {
      this.$emit("toggleSummary", value)
    }
  }
};
</script>

<style scoped lang="css">
.v-progress-linear {
  margin: auto !important
}
</style>
