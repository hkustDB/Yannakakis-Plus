create or replace view aggView4290141521831445659 as select id as v11, title as v44 from title as t where episode_nr>=50 and episode_nr<100;
create or replace view aggView8546538772913199675 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin2401529772637589366 as (
with aggView8744597610838667917 as (select v2, MIN(v3) as v55 from aggView8546538772913199675 group by v2)
select person_id as v2, movie_id as v11, v55 from cast_info as ci, aggView8744597610838667917 where ci.person_id=aggView8744597610838667917.v2);
create or replace view aggJoin4649607859409251922 as (
with aggView6613603352376231877 as (select id as v2 from name as n)
select v11, v55 from aggJoin2401529772637589366 join aggView6613603352376231877 using(v2));
create or replace view aggJoin8471740548744371986 as (
with aggView450481967480537341 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView450481967480537341 where mk.keyword_id=aggView450481967480537341.v33);
create or replace view aggJoin2230507481299647236 as (
with aggView1649471680543030056 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView1649471680543030056 where mc.company_id=aggView1649471680543030056.v28);
create or replace view aggJoin8405459410958836083 as (
with aggView1668566960415076902 as (select v11 from aggJoin8471740548744371986 group by v11)
select v11 from aggJoin2230507481299647236 join aggView1668566960415076902 using(v11));
create or replace view aggJoin6403291733543791739 as (
with aggView8035162594764239637 as (select v11 from aggJoin8405459410958836083 group by v11)
select v11, v55 as v55 from aggJoin4649607859409251922 join aggView8035162594764239637 using(v11));
create or replace view aggJoin6836672657242557012 as (
with aggView2125424655166662304 as (select v11, MIN(v55) as v55 from aggJoin6403291733543791739 group by v11,v55)
select v44, v55 from aggView4290141521831445659 join aggView2125424655166662304 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin6836672657242557012;
