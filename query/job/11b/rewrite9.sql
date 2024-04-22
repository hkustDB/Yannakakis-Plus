create or replace view aggJoin6129481647097222158 as (
with aggView3097331800375729969 as (select title as v28, id as v24 from title as t where production_year= 1998)
select v24, v28 from aggView3097331800375729969 where v28 LIKE '%Money%');
create or replace view aggView4525743966298291713 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin3998544688686180108 as (
with aggView1960675954515860449 as (select v17, MIN(v2) as v39 from aggView4525743966298291713 group by v17)
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView1960675954515860449 where mc.company_id=aggView1960675954515860449.v17);
create or replace view aggJoin7351101381424788667 as (
with aggView8282138246307117779 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView8282138246307117779 where ml.link_type_id=aggView8282138246307117779.v13);
create or replace view aggJoin6409880454004195695 as (
with aggView4514897172597134548 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView4514897172597134548 where mk.keyword_id=aggView4514897172597134548.v22);
create or replace view aggJoin6176055848451630414 as (
with aggView2663387825718380523 as (select v24 from aggJoin6409880454004195695 group by v24)
select v24, v18, v39 as v39 from aggJoin3998544688686180108 join aggView2663387825718380523 using(v24));
create or replace view aggJoin1607917816570264221 as (
with aggView7804806694487676181 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin6176055848451630414 join aggView7804806694487676181 using(v18));
create or replace view aggJoin4601006931199100747 as (
with aggView3969184865567917251 as (select v24, MIN(v39) as v39 from aggJoin1607917816570264221 group by v24,v39)
select v24, v40 as v40, v39 from aggJoin7351101381424788667 join aggView3969184865567917251 using(v24));
create or replace view aggJoin9110957844795293848 as (
with aggView2753817889554331076 as (select v24, MIN(v40) as v40, MIN(v39) as v39 from aggJoin4601006931199100747 group by v24,v39,v40)
select v28, v40, v39 from aggJoin6129481647097222158 join aggView2753817889554331076 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v28) as v41 from aggJoin9110957844795293848;
