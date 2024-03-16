create or replace view aggView4385941148330223972 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin401410156796638387 as select movie_id as v12 from movie_keyword as mk, aggView4385941148330223972 where mk.keyword_id=aggView4385941148330223972.v18;
create or replace view aggView5105788076231763501 as select v12 from aggJoin401410156796638387 group by v12;
create or replace view aggJoin1637348898292155885 as select id as v12, title as v20 from title as t, aggView5105788076231763501 where t.id=aggView5105788076231763501.v12;
create or replace view aggView3206335004540256199 as select v12, MIN(v20) as v31 from aggJoin1637348898292155885 group by v12;
create or replace view aggJoin1620704061364608611 as select company_id as v1, v31 from movie_companies as mc, aggView3206335004540256199 where mc.movie_id=aggView3206335004540256199.v12;
create or replace view aggView4451833792263385536 as select v1, MIN(v31) as v31 from aggJoin1620704061364608611 group by v1;
create or replace view aggJoin8370703357646619619 as select country_code as v3, v31 from company_name as cn, aggView4451833792263385536 where cn.id=aggView4451833792263385536.v1 and country_code= '[sm]';
select MIN(v31) as v31 from aggJoin8370703357646619619;
