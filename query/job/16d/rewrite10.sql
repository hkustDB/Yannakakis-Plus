create or replace view aggView1675948290070697116 as select title as v44, id as v11 from title as t where episode_nr>=5 and episode_nr<100;
create or replace view aggJoin148441450914036998 as (
with aggView6105044923594324570 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView6105044923594324570 where an.person_id=aggView6105044923594324570.v2);
create or replace view aggView1124735697694278899 as select v2, v3 from aggJoin148441450914036998 group by v2,v3;
create or replace view aggJoin1472631812119489596 as (
with aggView3656520769969636390 as (select v11, MIN(v44) as v56 from aggView1675948290070697116 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView3656520769969636390 where ci.movie_id=aggView3656520769969636390.v11);
create or replace view aggJoin2513930674594926929 as (
with aggView1029693097263201995 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView1029693097263201995 where mc.company_id=aggView1029693097263201995.v28);
create or replace view aggJoin5393359781171858678 as (
with aggView2365133937464443511 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView2365133937464443511 where mk.keyword_id=aggView2365133937464443511.v33);
create or replace view aggJoin4899063987366320661 as (
with aggView574191704095588287 as (select v11 from aggJoin5393359781171858678 group by v11)
select v2, v11, v56 as v56 from aggJoin1472631812119489596 join aggView574191704095588287 using(v11));
create or replace view aggJoin1651647040772809083 as (
with aggView6459381485652168557 as (select v11 from aggJoin2513930674594926929 group by v11)
select v2, v56 as v56 from aggJoin4899063987366320661 join aggView6459381485652168557 using(v11));
create or replace view aggJoin7230152802358691241 as (
with aggView8671005977896844801 as (select v2, MIN(v56) as v56 from aggJoin1651647040772809083 group by v2,v56)
select v3, v56 from aggView1124735697694278899 join aggView8671005977896844801 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin7230152802358691241;
