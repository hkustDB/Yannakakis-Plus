create or replace view aggJoin6697793611528581118 as (
with aggView7009560680305320424 as (select id as v8 from company_type as ct where kind= 'production companies')
select movie_id as v22, company_id as v1 from movie_companies as mc, aggView7009560680305320424 where mc.company_type_id=aggView7009560680305320424.v8);
create or replace view aggJoin1594971728787013829 as (
with aggView6232257707757246199 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView6232257707757246199 where miidx.info_type_id=aggView6232257707757246199.v10);
create or replace view aggJoin1810414836874249191 as (
with aggView485639507220854019 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22, info as v24 from movie_info as mi, aggView485639507220854019 where mi.info_type_id=aggView485639507220854019.v12);
create or replace view aggJoin5505352492837509855 as (
with aggView8007654440395267360 as (select id as v1 from company_name as cn where country_code= '[de]')
select v22 from aggJoin6697793611528581118 join aggView8007654440395267360 using(v1));
create or replace view aggJoin8407412856949606783 as (
with aggView5836924531855097501 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView5836924531855097501 where t.kind_id=aggView5836924531855097501.v14);
create or replace view aggJoin5682563680715646619 as (
with aggView3502652868008521522 as (select v22, MIN(v32) as v45 from aggJoin8407412856949606783 group by v22)
select v22, v24, v45 from aggJoin1810414836874249191 join aggView3502652868008521522 using(v22));
create or replace view aggJoin5594215648394469890 as (
with aggView3380639823601473356 as (select v22 from aggJoin5505352492837509855 group by v22)
select v22, v29 from aggJoin1594971728787013829 join aggView3380639823601473356 using(v22));
create or replace view aggJoin7267861824072207584 as (
with aggView8564820307683337760 as (select v22, MIN(v29) as v44 from aggJoin5594215648394469890 group by v22)
select v24, v45 as v45, v44 from aggJoin5682563680715646619 join aggView8564820307683337760 using(v22));
select MIN(v24) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin7267861824072207584;
