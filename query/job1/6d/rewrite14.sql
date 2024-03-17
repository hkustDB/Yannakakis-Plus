create or replace view aggView5319027811191766811 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3939135678420187088 as select movie_id as v23, v35 from movie_keyword as mk, aggView5319027811191766811 where mk.keyword_id=aggView5319027811191766811.v8;
create or replace view aggView1755132535895985481 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4889574680217955712 as select movie_id as v23, v36 from cast_info as ci, aggView1755132535895985481 where ci.person_id=aggView1755132535895985481.v14;
create or replace view aggView5273966122255324072 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin2914163294092899308 as select v23, v36, v37 from aggJoin4889574680217955712 join aggView5273966122255324072 using(v23);
create or replace view aggView8162675709130030284 as select v23, MIN(v35) as v35 from aggJoin3939135678420187088 group by v23;
create or replace view aggJoin6505170231822655126 as select v36 as v36, v37 as v37, v35 from aggJoin2914163294092899308 join aggView8162675709130030284 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6505170231822655126;
