create or replace view aggView163151806624967212 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5400762859672700385 as select movie_id as v23, v36 from cast_info as ci, aggView163151806624967212 where ci.person_id=aggView163151806624967212.v14;
create or replace view aggView1234648633781505268 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5435794418197837501 as select movie_id as v23, v35 from movie_keyword as mk, aggView1234648633781505268 where mk.keyword_id=aggView1234648633781505268.v8;
create or replace view aggView2677729302292137084 as select v23, MIN(v35) as v35 from aggJoin5435794418197837501 group by v23;
create or replace view aggJoin5998229550914658014 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView2677729302292137084 where t.id=aggView2677729302292137084.v23 and production_year>2000;
create or replace view aggView9059913649874473760 as select v23, MIN(v36) as v36 from aggJoin5400762859672700385 group by v23;
create or replace view aggJoin4277001950487053908 as select v24, v27, v35 as v35, v36 from aggJoin5998229550914658014 join aggView9059913649874473760 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin4277001950487053908;
