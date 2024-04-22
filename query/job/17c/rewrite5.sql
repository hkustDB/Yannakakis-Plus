create or replace view aggJoin1556589233427952604 as (
with aggView4895082803123859811 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView4895082803123859811 where mc.company_id=aggView4895082803123859811.v20);
create or replace view aggJoin2627868233178416457 as (
with aggView7038924704321852806 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7038924704321852806 where mk.keyword_id=aggView7038924704321852806.v25);
create or replace view aggJoin590298251488049752 as (
with aggView2215784314716829335 as (select v3 from aggJoin1556589233427952604 group by v3)
select v3 from aggJoin2627868233178416457 join aggView2215784314716829335 using(v3));
create or replace view aggJoin5295976674254168171 as (
with aggView1892657895095970907 as (select v3 from aggJoin590298251488049752 group by v3)
select id as v3 from title as t, aggView1892657895095970907 where t.id=aggView1892657895095970907.v3);
create or replace view aggJoin3337252511683760076 as (
with aggView1528295714755627954 as (select v3 from aggJoin5295976674254168171 group by v3)
select person_id as v26 from cast_info as ci, aggView1528295714755627954 where ci.movie_id=aggView1528295714755627954.v3);
create or replace view aggJoin605283257767575505 as (
with aggView54858252299719960 as (select v26 from aggJoin3337252511683760076 group by v26)
select name as v27 from name as n, aggView54858252299719960 where n.id=aggView54858252299719960.v26 and name LIKE 'X%');
create or replace view aggView4430984056101057803 as select v27 from aggJoin605283257767575505 group by v27;
select MIN(v27) as v47 from aggView4430984056101057803;
