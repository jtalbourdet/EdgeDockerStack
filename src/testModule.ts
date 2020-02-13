export default class demoClass {
    msg: String = 'bonjour'
    numb: Number = 12
    constructor(){
        console.log('Instance started')

        this.msg = this.numb.toString()
    }

    public demoMsg() {
        this.numb = (this.numb + 1)
        console.log(this.numb);
    }
}