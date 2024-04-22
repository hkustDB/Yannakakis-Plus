create or replace view aggJoin3336189386455972595 as (
with aggView3564789829642719684 as (select title as v38, id as v37 from title as t where production_year>2010)
select v37, v38 from aggView3564789829642719684 where v38 LIKE 'Vampire%');
create or replace view aggView8104697736182215080 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin5809697486651793771 as (
with aggView6134352907037018888 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView6134352907037018888 where mi.info_type_id=aggView6134352907037018888.v8);
create or replace view aggJoin1057241741791416266 as (
with aggView8092251464048809508 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView8092251464048809508 where mk.keyword_id=aggView8092251464048809508.v12);
create or replace view aggJoin6403205532221904548 as (
with aggView2143578574599147885 as (select v37 from aggJoin1057241741791416266 group by v37)
select v37, v18 from aggJoin5809697486651793771 join aggView2143578574599147885 using(v37));
create or replace view aggJoin6380969085452997382 as (
with aggView5710560433243019063 as (select v18, v37 from aggJoin6403205532221904548 group by v18,v37)
select v37, v18 from aggView5710560433243019063 where v18= 'Horror');
create or replace view aggJoin7260606937243040644 as (
with aggView2212761110639199247 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView2212761110639199247 where mi_idx.info_type_id=aggView2212761110639199247.v10);
create or replace view aggView375302280010626609 as select v23, v37 from aggJoin7260606937243040644 group by v23,v37;
create or replace view aggJoin1824992362984122678 as (
with aggView8333169715678912217 as (select v37, MIN(v18) as v49 from aggJoin6380969085452997382 group by v37)
select person_id as v28, movie_id as v37, note as v5, v49 from cast_info as ci, aggView8333169715678912217 where ci.movie_id=aggView8333169715678912217.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6270864544237929163 as (
with aggView1343555541663317249 as (select v28, MIN(v29) as v51 from aggView8104697736182215080 group by v28)
select v37, v5, v49 as v49, v51 from aggJoin1824992362984122678 join aggView1343555541663317249 using(v28));
create or replace view aggJoin6989233968263212789 as (
with aggView2407647217074011246 as (select v37, MIN(v23) as v50 from aggView375302280010626609 group by v37)
select v37, v5, v49 as v49, v51 as v51, v50 from aggJoin6270864544237929163 join aggView2407647217074011246 using(v37));
create or replace view aggJoin5438117190017999839 as (
with aggView811461268995791204 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v50) as v50 from aggJoin6989233968263212789 group by v37,v50,v49,v51)
select v38, v49, v51, v50 from aggJoin3336189386455972595 join aggView811461268995791204 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v38) as v52 from aggJoin5438117190017999839;
