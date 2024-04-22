create or replace view aggJoin8236971848427249993 as (
with aggView2561287201836568733 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView2561287201836568733 where ci.person_id=aggView2561287201836568733.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin6611350487187814241 as (
with aggView8449241937058055788 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView8449241937058055788 where mi_idx.info_type_id=aggView8449241937058055788.v10);
create or replace view aggJoin6827271056964415765 as (
with aggView6674281749241080957 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView6674281749241080957 where mk.keyword_id=aggView6674281749241080957.v12);
create or replace view aggJoin8834334072333773963 as (
with aggView1909543204579438737 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView1909543204579438737 where mi.info_type_id=aggView1909543204579438737.v8 and info= 'Horror');
create or replace view aggJoin3326595968530213186 as (
with aggView6960712002696307616 as (select v37, MIN(v18) as v49 from aggJoin8834334072333773963 group by v37)
select v37, v23, v49 from aggJoin6611350487187814241 join aggView6960712002696307616 using(v37));
create or replace view aggJoin8045859914358769389 as (
with aggView2955163123781475092 as (select v37, MIN(v49) as v49, MIN(v23) as v50 from aggJoin3326595968530213186 group by v37,v49)
select v37, v5, v51 as v51, v49, v50 from aggJoin8236971848427249993 join aggView2955163123781475092 using(v37));
create or replace view aggJoin3704915343950501652 as (
with aggView1988165355797680272 as (select v37, MIN(v51) as v51, MIN(v49) as v49, MIN(v50) as v50 from aggJoin8045859914358769389 group by v37,v51,v49,v50)
select id as v37, title as v38, v51, v49, v50 from title as t, aggView1988165355797680272 where t.id=aggView1988165355797680272.v37);
create or replace view aggJoin1684041771722743039 as (
with aggView1260537156289472498 as (select v37, MIN(v51) as v51, MIN(v49) as v49, MIN(v50) as v50, MIN(v38) as v52 from aggJoin3704915343950501652 group by v37,v51,v49,v50)
select v51, v49, v50, v52 from aggJoin6827271056964415765 join aggView1260537156289472498 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin1684041771722743039;
