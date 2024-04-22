create or replace view aggJoin859903730052803837 as (
with aggView2050159656526299168 as (select id as v26, name as v47 from name as n where name LIKE 'Z%')
select movie_id as v3, v47 from cast_info as ci, aggView2050159656526299168 where ci.person_id=aggView2050159656526299168.v26);
create or replace view aggJoin4597100227929341494 as (
with aggView4869755165490471739 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView4869755165490471739 where mc.company_id=aggView4869755165490471739.v20);
create or replace view aggJoin7516975022189133182 as (
with aggView8482283427200628927 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8482283427200628927 where mk.keyword_id=aggView8482283427200628927.v25);
create or replace view aggJoin1118155460871430382 as (
with aggView8236504733747104752 as (select v3 from aggJoin7516975022189133182 group by v3)
select id as v3 from title as t, aggView8236504733747104752 where t.id=aggView8236504733747104752.v3);
create or replace view aggJoin7729219833173616918 as (
with aggView7191983238626741730 as (select v3 from aggJoin1118155460871430382 group by v3)
select v3, v47 as v47 from aggJoin859903730052803837 join aggView7191983238626741730 using(v3));
create or replace view aggJoin4446137425050055668 as (
with aggView1123380027229961686 as (select v3 from aggJoin4597100227929341494 group by v3)
select v47 as v47 from aggJoin7729219833173616918 join aggView1123380027229961686 using(v3));
select MIN(v47) as v47 from aggJoin4446137425050055668;
