create or replace view aggView4195578399683916718 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggView3181666112417599751 as select title as v28, id as v24 from title as t where production_year<=2000 and production_year>=1950;
create or replace view aggJoin7255100982649273905 as (
with aggView4981318620595997598 as (select v24, MIN(v28) as v41 from aggView3181666112417599751 group by v24)
select movie_id as v24, company_id as v17, company_type_id as v18, v41 from movie_companies as mc, aggView4981318620595997598 where mc.movie_id=aggView4981318620595997598.v24);
create or replace view aggJoin7597417831592116646 as (
with aggView3659187177504508258 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select movie_id as v24, v40 from movie_link as ml, aggView3659187177504508258 where ml.link_type_id=aggView3659187177504508258.v13);
create or replace view aggJoin6841764517135294330 as (
with aggView3249165397426792841 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView3249165397426792841 where mk.keyword_id=aggView3249165397426792841.v22);
create or replace view aggJoin5192798047482695736 as (
with aggView1980194862000736510 as (select v24 from aggJoin6841764517135294330 group by v24)
select v24, v40 as v40 from aggJoin7597417831592116646 join aggView1980194862000736510 using(v24));
create or replace view aggJoin6726226963483676921 as (
with aggView1379919727543747180 as (select v24, MIN(v40) as v40 from aggJoin5192798047482695736 group by v24,v40)
select v17, v18, v41 as v41, v40 from aggJoin7255100982649273905 join aggView1379919727543747180 using(v24));
create or replace view aggJoin6593286969139973839 as (
with aggView4931292131669057596 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v41, v40 from aggJoin6726226963483676921 join aggView4931292131669057596 using(v18));
create or replace view aggJoin280968799882180249 as (
with aggView3408109666086393861 as (select v17, MIN(v41) as v41, MIN(v40) as v40 from aggJoin6593286969139973839 group by v17,v40,v41)
select v2, v41, v40 from aggView4195578399683916718 join aggView3408109666086393861 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin280968799882180249;
