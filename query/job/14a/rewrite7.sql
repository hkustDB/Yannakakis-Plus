create or replace view aggJoin7757569565645453436 as (
with aggView2787724101972054127 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView2787724101972054127 where mi_idx.info_type_id=aggView2787724101972054127.v3);
create or replace view aggJoin497570009652126159 as (
with aggView8101117035713563651 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView8101117035713563651 where mk.keyword_id=aggView8101117035713563651.v5);
create or replace view aggJoin8716946676699316683 as (
with aggView6657010328149548426 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView6657010328149548426 where mi.info_type_id=aggView6657010328149548426.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin558534669262588949 as (
with aggView1355346454599227613 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView1355346454599227613 where t.kind_id=aggView1355346454599227613.v8 and production_year>2010);
create or replace view aggJoin2547321717777078071 as (
with aggView1249669758866596695 as (select v23 from aggJoin497570009652126159 group by v23)
select v23, v18 from aggJoin7757569565645453436 join aggView1249669758866596695 using(v23));
create or replace view aggJoin7234096690776956847 as (
with aggView2216039299828995880 as (select v23, v18 from aggJoin2547321717777078071 group by v23,v18)
select v23, v18 from aggView2216039299828995880 where v18<'8.5');
create or replace view aggJoin470907628254025442 as (
with aggView5080077337303768966 as (select v23 from aggJoin8716946676699316683 group by v23)
select v23, v24, v27 from aggJoin558534669262588949 join aggView5080077337303768966 using(v23));
create or replace view aggView5495983592794728705 as select v23, v24 from aggJoin470907628254025442 group by v23,v24;
create or replace view aggJoin124371679269358211 as (
with aggView8298887818899847690 as (select v23, MIN(v18) as v35 from aggJoin7234096690776956847 group by v23)
select v24, v35 from aggView5495983592794728705 join aggView8298887818899847690 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin124371679269358211;
