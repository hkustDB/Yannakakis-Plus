create or replace view aggView4816062956969383779 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8060158888960841677 as select movie_id as v12 from movie_keyword as mk, aggView4816062956969383779 where mk.keyword_id=aggView4816062956969383779.v18;
create or replace view aggView8290184508819197838 as select v12 from aggJoin8060158888960841677 group by v12;
create or replace view aggJoin6888604556615881504 as select id as v12, title as v20 from title as t, aggView8290184508819197838 where t.id=aggView8290184508819197838.v12;
create or replace view aggView3536265166202377010 as select v12, MIN(v20) as v31 from aggJoin6888604556615881504 group by v12;
create or replace view aggJoin23304740654310300 as select company_id as v1, v31 from movie_companies as mc, aggView3536265166202377010 where mc.movie_id=aggView3536265166202377010.v12;
create or replace view aggView4027033745287175384 as select v1, MIN(v31) as v31 from aggJoin23304740654310300 group by v1;
create or replace view aggJoin8791164327879101134 as select country_code as v3, v31 from company_name as cn, aggView4027033745287175384 where cn.id=aggView4027033745287175384.v1 and country_code= '[nl]';
select MIN(v31) as v31 from aggJoin8791164327879101134;
