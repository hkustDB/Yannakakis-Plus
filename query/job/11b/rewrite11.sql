create or replace view aggJoin1342764486430651214 as (
with aggView4502177051139446229 as (select title as v28, id as v24 from title as t where production_year= 1998)
select v24, v28 from aggView4502177051139446229 where v28 LIKE '%Money%');
create or replace view aggView350372619142173876 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin4194087200741641953 as (
with aggView5054390419718743523 as (select v24, MIN(v28) as v41 from aggJoin1342764486430651214 group by v24)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView5054390419718743523 where ml.movie_id=aggView5054390419718743523.v24);
create or replace view aggJoin6938597813350208456 as (
with aggView9001390341470967956 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select v24, v41, v40 from aggJoin4194087200741641953 join aggView9001390341470967956 using(v13));
create or replace view aggJoin4267666184181306750 as (
with aggView4411157303330516216 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView4411157303330516216 where mk.keyword_id=aggView4411157303330516216.v22);
create or replace view aggJoin8880085427038474661 as (
with aggView6397818617539634346 as (select v24 from aggJoin4267666184181306750 group by v24)
select v24, v41 as v41, v40 as v40 from aggJoin6938597813350208456 join aggView6397818617539634346 using(v24));
create or replace view aggJoin6447321444225862765 as (
with aggView2128362770365387731 as (select v24, MIN(v41) as v41, MIN(v40) as v40 from aggJoin8880085427038474661 group by v24,v40,v41)
select company_id as v17, company_type_id as v18, v41, v40 from movie_companies as mc, aggView2128362770365387731 where mc.movie_id=aggView2128362770365387731.v24);
create or replace view aggJoin839790624282433376 as (
with aggView3816552762353117254 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v41, v40 from aggJoin6447321444225862765 join aggView3816552762353117254 using(v18));
create or replace view aggJoin7943160351403200274 as (
with aggView2391938578138747760 as (select v17, MIN(v41) as v41, MIN(v40) as v40 from aggJoin839790624282433376 group by v17,v40,v41)
select v2, v41, v40 from aggView350372619142173876 join aggView2391938578138747760 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin7943160351403200274;
