# HxVue3
可以使用Haxe编写vue3的API，并且自带了elementui的组件。

## 使用
我们可以使用**Vue3**的原始API，创建一个app，并挂载到**#app**身上：
```haxe
var app = new App();
var vue = Vue.createApp(app);
vue.use(ElementPlus);
vue.mount("#app");
```
>[!Tip]可参考**test**目录下的实例