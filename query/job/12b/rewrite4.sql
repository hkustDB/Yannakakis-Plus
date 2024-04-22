create or replace view aggJoin3366761769062719563 as (
with aggView1209138502814522860 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView1209138502814522860 where mi.info_type_id=aggView1209138502814522860.v21);
create or replace view aggJoin2663785345258991220 as (
with aggView2207734396132894898 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView2207734396132894898 where mc.company_id=aggView2207734396132894898.v1);
create or replace view aggJoin7654120733938436877 as (
with aggView4748848182365864596 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin2663785345258991220 join aggView4748848182365864596 using(v8));
create or replace view aggJoin5127848779432676850 as (
with aggView6978060530582540329 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView6978060530582540329 where mi_idx.info_type_id=aggView6978060530582540329.v26);
create or replace view aggJoin1421641476740742798 as (
with aggView1088838341967359190 as (select v29 from aggJoin7654120733938436877 group by v29)
select v29, v22 from aggJoin3366761769062719563 join aggView1088838341967359190 using(v29));
create or replace view aggView2118325180945127619 as select v29, v22 from aggJoin1421641476740742798 group by v29,v22;
create or replace view aggJoin8605442678741883337 as (
with aggView2706118793308163869 as (select v29 from aggJoin5127848779432676850 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView2706118793308163869 where t.id=aggView2706118793308163869.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggView6801032294564613849 as select v29, v30 from aggJoin8605442678741883337 group by v29,v30;
create or replace view aggJoin1334302846265903992 as (
with aggView383724207010062811 as (select v29, MIN(v22) as v41 from aggView2118325180945127619 group by v29)
select v30, v41 from aggView6801032294564613849 join aggView383724207010062811 using(v29));
select MIN(v41) as v41,MIN(v30) as v42 from aggJoin1334302846265903992;
