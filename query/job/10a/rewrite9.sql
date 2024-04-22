create or replace view aggJoin6505390214805462091 as (
with aggView1781307466197345608 as (select id as v31, title as v44 from title as t where production_year>2005)
select movie_id as v31, company_id as v15, company_type_id as v22, v44 from movie_companies as mc, aggView1781307466197345608 where mc.movie_id=aggView1781307466197345608.v31);
create or replace view aggJoin4315289514210963680 as (
with aggView2766239854944140082 as (select id as v1, name as v43 from char_name as chn)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView2766239854944140082 where ci.person_role_id=aggView2766239854944140082.v1 and note LIKE '%(voice)%' and note LIKE '%(uncredited)%');
create or replace view aggJoin4448764988725812323 as (
with aggView5214626939695604375 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v12, v43 from aggJoin4315289514210963680 join aggView5214626939695604375 using(v29));
create or replace view aggJoin5205520872844049058 as (
with aggView7349902046284381446 as (select id as v22 from company_type as ct)
select v31, v15, v44 from aggJoin6505390214805462091 join aggView7349902046284381446 using(v22));
create or replace view aggJoin1212227022512978702 as (
with aggView2184780429089870880 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31, v44 from aggJoin5205520872844049058 join aggView2184780429089870880 using(v15));
create or replace view aggJoin6787775416337747120 as (
with aggView523717167314848355 as (select v31, MIN(v43) as v43 from aggJoin4448764988725812323 group by v31,v43)
select v44 as v44, v43 from aggJoin1212227022512978702 join aggView523717167314848355 using(v31));
select MIN(v43) as v43,MIN(v44) as v44 from aggJoin6787775416337747120;
