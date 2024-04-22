create or replace view aggView3723000600148808604 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin7259943795235188328 as (
with aggView3575508710835490247 as (select title as v38, id as v37 from title as t where production_year>2010)
select v37, v38 from aggView3575508710835490247 where v38 LIKE 'Vampire%');
create or replace view aggJoin5709091212883673285 as (
with aggView3149773960469392663 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView3149773960469392663 where mi.info_type_id=aggView3149773960469392663.v8 and info= 'Horror');
create or replace view aggView6407076353229000664 as select v18, v37 from aggJoin5709091212883673285 group by v18,v37;
create or replace view aggJoin1769440973195815053 as (
with aggView717168750166991603 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView717168750166991603 where mi_idx.info_type_id=aggView717168750166991603.v10);
create or replace view aggView2364495558384821142 as select v23, v37 from aggJoin1769440973195815053 group by v23,v37;
create or replace view aggJoin5840771036726114922 as (
with aggView5813356779252350905 as (select v37, MIN(v38) as v52 from aggJoin7259943795235188328 group by v37)
select person_id as v28, movie_id as v37, note as v5, v52 from cast_info as ci, aggView5813356779252350905 where ci.movie_id=aggView5813356779252350905.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin1614441781836428603 as (
with aggView4907254310145848082 as (select v37, MIN(v18) as v49 from aggView6407076353229000664 group by v37)
select v23, v37, v49 from aggView2364495558384821142 join aggView4907254310145848082 using(v37));
create or replace view aggJoin4157272992150320938 as (
with aggView3005552722799804765 as (select v37, MIN(v49) as v49, MIN(v23) as v50 from aggJoin1614441781836428603 group by v37,v49)
select v28, v37, v5, v52 as v52, v49, v50 from aggJoin5840771036726114922 join aggView3005552722799804765 using(v37));
create or replace view aggJoin1453617287383693197 as (
with aggView3700564597037191748 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView3700564597037191748 where mk.keyword_id=aggView3700564597037191748.v12);
create or replace view aggJoin557968433217816440 as (
with aggView7214013784471651420 as (select v37 from aggJoin1453617287383693197 group by v37)
select v28, v5, v52 as v52, v49 as v49, v50 as v50 from aggJoin4157272992150320938 join aggView7214013784471651420 using(v37));
create or replace view aggJoin4537428367651257512 as (
with aggView7429709212409266184 as (select v28, MIN(v52) as v52, MIN(v49) as v49, MIN(v50) as v50 from aggJoin557968433217816440 group by v28,v50,v52,v49)
select v29, v52, v49, v50 from aggView3723000600148808604 join aggView7429709212409266184 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin4537428367651257512;
