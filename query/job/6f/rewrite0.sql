create or replace view aggView1651209086329636202 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1133212974856829554 as select movie_id as v23, v35 from movie_keyword as mk, aggView1651209086329636202 where mk.keyword_id=aggView1651209086329636202.v8;
create or replace view aggView5804482361246967875 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7368043662877003148 as select v23, v35, v37 from aggJoin1133212974856829554 join aggView5804482361246967875 using(v23);
create or replace view aggView1426849226308249082 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin7368043662877003148 group by v23;
create or replace view aggJoin8727981164879635206 as select person_id as v14, v35, v37 from cast_info as ci, aggView1426849226308249082 where ci.movie_id=aggView1426849226308249082.v23;
create or replace view aggView7212877884416335301 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin8727981164879635206 group by v14;
create or replace view aggJoin5484722269295721906 as select name as v15, v35, v37 from name as n, aggView7212877884416335301 where n.id=aggView7212877884416335301.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin5484722269295721906;
