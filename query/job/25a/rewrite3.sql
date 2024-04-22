create or replace view aggView2666118990295695278 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin5024473592149668060 as (
with aggView2442522272661571137 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView2442522272661571137 where mi_idx.info_type_id=aggView2442522272661571137.v10);
create or replace view aggView31361106218156105 as select v23, v37 from aggJoin5024473592149668060 group by v23,v37;
create or replace view aggJoin5074080982287297169 as (
with aggView3664251363885180971 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView3664251363885180971 where mk.keyword_id=aggView3664251363885180971.v12);
create or replace view aggJoin5454036987721779808 as (
with aggView6132755199801476690 as (select v37 from aggJoin5074080982287297169 group by v37)
select id as v37, title as v38 from title as t, aggView6132755199801476690 where t.id=aggView6132755199801476690.v37);
create or replace view aggView2620314982945883104 as select v38, v37 from aggJoin5454036987721779808 group by v38,v37;
create or replace view aggJoin7830700019478499611 as (
with aggView4958951946596006920 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView4958951946596006920 where mi.info_type_id=aggView4958951946596006920.v8);
create or replace view aggJoin4600209935503646981 as (
with aggView3957547703414687917 as (select v18, v37 from aggJoin7830700019478499611 group by v18,v37)
select v37, v18 from aggView3957547703414687917 where v18= 'Horror');
create or replace view aggJoin6406244462330278963 as (
with aggView3838410238265621973 as (select v28, MIN(v29) as v51 from aggView2666118990295695278 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView3838410238265621973 where ci.person_id=aggView3838410238265621973.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin294246136069149929 as (
with aggView9155520283352418752 as (select v37, MIN(v51) as v51 from aggJoin6406244462330278963 group by v37,v51)
select v38, v37, v51 from aggView2620314982945883104 join aggView9155520283352418752 using(v37));
create or replace view aggJoin5498852213160308588 as (
with aggView538541607882222934 as (select v37, MIN(v51) as v51, MIN(v38) as v52 from aggJoin294246136069149929 group by v37,v51)
select v37, v18, v51, v52 from aggJoin4600209935503646981 join aggView538541607882222934 using(v37));
create or replace view aggJoin2561610680978590742 as (
with aggView3687346054765783745 as (select v37, MIN(v51) as v51, MIN(v52) as v52, MIN(v18) as v49 from aggJoin5498852213160308588 group by v37,v51,v52)
select v23, v51, v52, v49 from aggView31361106218156105 join aggView3687346054765783745 using(v37));
select MIN(v49) as v49,MIN(v23) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin2561610680978590742;
