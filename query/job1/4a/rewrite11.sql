create or replace view aggView7535338044651809123 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1414512310168572584 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7535338044651809123 where mi_idx.info_type_id=aggView7535338044651809123.v1 and info>'5.0';
create or replace view aggView1153080271424803143 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin914583463831507059 as select movie_id as v14 from movie_keyword as mk, aggView1153080271424803143 where mk.keyword_id=aggView1153080271424803143.v3;
create or replace view aggView4809904349683243998 as select v14 from aggJoin914583463831507059 group by v14;
create or replace view aggJoin386410666569919159 as select v14, v9 from aggJoin1414512310168572584 join aggView4809904349683243998 using(v14);
create or replace view aggView2745660181258098932 as select v14, MIN(v9) as v26 from aggJoin386410666569919159 group by v14;
create or replace view aggJoin8456469999340989832 as select title as v15, v26 from title as t, aggView2745660181258098932 where t.id=aggView2745660181258098932.v14 and production_year>2005;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin8456469999340989832;
