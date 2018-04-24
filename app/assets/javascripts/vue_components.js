Vue.component('tabs', {
  // note how a lot of the messiness of the tabs markup is moved out to the component
  template: `
    <div>
      <div class="row">
          <div class="col s12">
            <ul class="tabs">
              <li class="tab col s4" v-for="tab in tabs">
                <a v-bind:href="tab.href" v-bind:class="{ 'active': tab.isActive }" v-on:click="selectTab(tab)">{{ tab.name }}</a>
              </li>
            </ul>
          </div>
        </div>
      
        <div class="tab-details">
          <slot></slot>
        </div>
        
      </div>
  `,
  
  data() {
    
    return { tabs: [] };
    
  },
  
  created() {
    // using the created lifecycle hook here to populate the tab components based on 
    // what is on the html page
    this.tabs = this.$children;
    
  },
  
  methods: {
    // talk about use of the arrow functions in js; 
    // looping through each tab and determine if active or not
    selectTab(selectedTab) {
      this.tabs.forEach(tab => {
        tab.isActive = (tab.name == selectedTab.name)
      });
    }
  
  }
  
});

Vue.component('tab', {
  
  template: `
    <div v-show="isActive"><slot></slot></div>
  `,
  
  props: {
    // treat these as immutable
    name: { required: true },
    selected: { default: false }
    
  },
  
  data() {
    
    return {
      isActive: false
    };
    
  },
  
  computed: {
    href() {
      
      // also add in a replace() to change any possible spaces into dashes
      return "#" + this.name.toLowerCase().replace(/ /g, '-');
      
    }
  },
  
  mounted() {
    // set the tab marked as selected to active
    this.isActive = this.selected;
    
  }
});

var vm = new Vue({
  
  el: '#tabbed'
  
});