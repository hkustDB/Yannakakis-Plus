create or replace view aggJoin3389214556787082076 as (
with aggView4755475973369940783 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView4755475973369940783 where mc.company_id=aggView4755475973369940783.v20);
create or replace view aggJoin4854545392192888861 as (
with aggView6133800778826642596 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6133800778826642596 where mk.keyword_id=aggView6133800778826642596.v25);
create or replace view aggJoin3174231224058429485 as (
with aggView3126572879121414498 as (select id as v3 from title as t)
select v3 from aggJoin4854545392192888861 join aggView3126572879121414498 using(v3));
create or replace view aggJoin5051372400567386458 as (
with aggView3281931888142287694 as (select v3 from aggJoin3174231224058429485 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView3281931888142287694 where ci.movie_id=aggView3281931888142287694.v3);
create or replace view aggJoin7847259622965442417 as (
with aggView8703482154913013752 as (select v3 from aggJoin3389214556787082076 group by v3)
select v26 from aggJoin5051372400567386458 join aggView8703482154913013752 using(v3));
create or replace view aggJoin981045852655682103 as (
with aggView2302491398277800580 as (select v26 from aggJoin7847259622965442417 group by v26)
select name as v27 from name as n, aggView2302491398277800580 where n.id=aggView2302491398277800580.v26);
create or replace view aggView3229868784641060152 as select v27 from aggJoin981045852655682103 group by v27;
select MIN(v27) as v47 from aggView3229868784641060152;
