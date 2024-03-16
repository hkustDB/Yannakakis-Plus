create or replace view aggView6600540247797278655 as select id as v14, name as v36 from name as n;
create or replace view aggJoin8625721539044912256 as select movie_id as v23, v36 from cast_info as ci, aggView6600540247797278655 where ci.person_id=aggView6600540247797278655.v14;
create or replace view aggView7226203633983245989 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4889830126442762209 as select movie_id as v23, v35 from movie_keyword as mk, aggView7226203633983245989 where mk.keyword_id=aggView7226203633983245989.v8;
create or replace view aggView2878732364570473322 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin4409610462389834992 as select v23, v35 from aggJoin4889830126442762209 join aggView2878732364570473322 using(v23);
create or replace view aggView3995484488557850982 as select v23, MIN(v36) as v36 from aggJoin8625721539044912256 group by v23;
create or replace view aggJoin4620811538410009537 as select v35 as v35, v36 from aggJoin4409610462389834992 join aggView3995484488557850982 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4620811538410009537;
