import { createRouter, createWebHashHistory } from 'vue-router'

const routes = [
    {
        path: '/author',
        component: ()=>import( '../page/AuthorPage')
    }, {
        path: '/books',
        component: ()=>import('../page/BooksPage')
    }
]

const router = createRouter({ history: createWebHashHistory(), routes })
export default router