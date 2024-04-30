create or replace view aggView1342062308277581581 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7358336734095730241 as select movie_id as v12 from movie_keyword as mk, aggView1342062308277581581 where mk.keyword_id=aggView1342062308277581581.v1;
create or replace view aggView4076496897724758704 as select v12 from aggJoin7358336734095730241 group by v12;
create or replace view aggJoin3761135447438123245 as select movie_id as v12, info as v7 from movie_info as mi, aggView4076496897724758704 where mi.movie_id=aggView4076496897724758704.v12 and info= 'Bulgaria';
create or replace view aggView6110469101270435211 as select v12 from aggJoin3761135447438123245 group by v12;
create or replace view aggJoin8576090541177148656 as select title as v13, production_year as v16 from title as t, aggView6110469101270435211 where t.id=aggView6110469101270435211.v12 and production_year>2010;
create or replace view aggView4298974067344669441 as select v13 from aggJoin8576090541177148656;
select MIN(v13) as v24 from aggView4298974067344669441;
