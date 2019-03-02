<template>
    <v-app>
            <MainHeader v-model="search"></MainHeader>
            {{search}}
                <router-view :search="search"></router-view>
            <MainFooter></MainFooter>
    </v-app>
</template>

<script>
import MainHeader from "./MainHeader.vue";
import MainFooter from "./MainFooter.vue";

export default {
  data() {
    return {
        search: "",
    };
  },
  components: {
    MainHeader: MainHeader,
    MainFooter: MainFooter
  },
};
</script>
