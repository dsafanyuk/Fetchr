<template>
  <v-card>
    <v-data-table :headers="headers" :items="orders" v-bind:pagination.sync="pagination">
      <template slot="items" slot-scope="props">
        <tr @click="toggleDialog(props.item)">
          <td>{{props.item.order_id}}</td>
          <td>{{props.item.first_name}}</td>
          <td>{{props.item.room_num}}</td>
          <td>{{props.item.time_delivered}}</td>
        </tr>
      </template>
    </v-data-table>
  </v-card>
</template>
<script>
export default {
  data() {
    return {
      pagination: { sortBy: "order_id", descending: true, rowsPerPage: 5 },
      headers: [
        { text: "Order #", align: "left", value: "order_id" },
        { text: "Name", align: "left", value: "first_name" },
        { text: "Room #", align: "left", value: "room_num" },
        { text: "Time Delivered", align: "left", value: "time_delivered" },
      ],
     };
  },
  props: {
    orders: Array
  },
  computed: {},
  methods: {
  toggleDialog(value) {
      console.log('emit')
      this.$emit("toggleSummary", value)
    }
  }
};
</script>
    
    <style scoped lang="css">
</style>
    