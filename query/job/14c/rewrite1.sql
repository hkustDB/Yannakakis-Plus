create or replace view aggJoin7684408056916418084 as (
with aggView3500480605068751462 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView3500480605068751462 where mi_idx.info_type_id=aggView3500480605068751462.v3 and info<'8.5');
create or replace view aggJoin7785620518943253743 as (
with aggView3402750165729598340 as (select id as v8 from kind_type as kt where kind IN ('movie','episode'))
select id as v23, title as v24, production_year as v27 from title as t, aggView3402750165729598340 where t.kind_id=aggView3402750165729598340.v8 and production_year>2005);
create or replace view aggJoin2783825069948634787 as (
with aggView1277010309053364447 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView1277010309053364447 where mk.keyword_id=aggView1277010309053364447.v5);
create or replace view aggJoin173812029917940648 as (
with aggView4975579263355226616 as (select v23 from aggJoin2783825069948634787 group by v23)
select v23, v24, v27 from aggJoin7785620518943253743 join aggView4975579263355226616 using(v23));
create or replace view aggView7482599544060512834 as select v24, v23 from aggJoin173812029917940648 group by v24,v23;
create or replace view aggJoin7271784782438783088 as (
with aggView6781481003323409982 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView6781481003323409982 where mi.info_type_id=aggView6781481003323409982.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1412161157564331251 as (
with aggView6281904348933526678 as (select v23 from aggJoin7271784782438783088 group by v23)
select v23, v18 from aggJoin7684408056916418084 join aggView6281904348933526678 using(v23));
create or replace view aggView3562119504790314291 as select v18, v23 from aggJoin1412161157564331251 group by v18,v23;
create or replace view aggJoin7270193730986391116 as (
with aggView6435836228874322497 as (select v23, MIN(v18) as v35 from aggView3562119504790314291 group by v23)
select v24, v35 from aggView7482599544060512834 join aggView6435836228874322497 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin7270193730986391116;
