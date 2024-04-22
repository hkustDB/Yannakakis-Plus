create or replace view aggView913566038998643710 as select title as v28, id as v24 from title as t where production_year>1950;
create or replace view aggView2110314461285057488 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%'));
create or replace view aggJoin3913326357651872638 as (
with aggView1686852191772894176 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView1686852191772894176 where mk.keyword_id=aggView1686852191772894176.v22);
create or replace view aggJoin7322154564729864820 as (
with aggView4596682720902512520 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView4596682720902512520 where mc.company_type_id=aggView4596682720902512520.v18);
create or replace view aggJoin8973553364453125879 as (
with aggView114033820134281479 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView114033820134281479 where ml.link_type_id=aggView114033820134281479.v13);
create or replace view aggJoin483977499011127145 as (
with aggView3121370980889483540 as (select v24 from aggJoin8973553364453125879 group by v24)
select v24 from aggJoin3913326357651872638 join aggView3121370980889483540 using(v24));
create or replace view aggJoin5082715830575737776 as (
with aggView3301296332718095173 as (select v24 from aggJoin483977499011127145 group by v24)
select v24, v17, v19 from aggJoin7322154564729864820 join aggView3301296332718095173 using(v24));
create or replace view aggView1931127625793404776 as select v19, v24, v17 from aggJoin5082715830575737776 group by v19,v24,v17;
create or replace view aggJoin6235991735763844740 as (
with aggView625350831268836446 as (select v24, MIN(v28) as v41 from aggView913566038998643710 group by v24)
select v19, v17, v41 from aggView1931127625793404776 join aggView625350831268836446 using(v24));
create or replace view aggJoin7802777107442395391 as (
with aggView5387037604852400087 as (select v17, MIN(v41) as v41, MIN(v19) as v40 from aggJoin6235991735763844740 group by v17,v41)
select v2, v41, v40 from aggView2110314461285057488 join aggView5387037604852400087 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin7802777107442395391;
