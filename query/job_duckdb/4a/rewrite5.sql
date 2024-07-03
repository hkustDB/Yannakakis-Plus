create or replace view aggView3862971931798988551 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2136003696968292386 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3862971931798988551 where mi_idx.info_type_id=aggView3862971931798988551.v1 and info>'5.0';
create or replace view aggView5096400305740824373 as select v14, MIN(v9) as v26 from aggJoin2136003696968292386 group by v14;
create or replace view aggJoin4962742517204360422 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView5096400305740824373 where t.id=aggView5096400305740824373.v14 and production_year>2005;
create or replace view aggView5513922046911864496 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5916439404624990877 as select movie_id as v14 from movie_keyword as mk, aggView5513922046911864496 where mk.keyword_id=aggView5513922046911864496.v3;
create or replace view aggView965468677892080622 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin4962742517204360422 group by v14,v26;
create or replace view aggJoin2536778688111688570 as select v26, v27 from aggJoin5916439404624990877 join aggView965468677892080622 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2536778688111688570;
