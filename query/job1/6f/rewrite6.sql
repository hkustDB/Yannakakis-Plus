create or replace view aggView2560269802861268103 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1813559384612560794 as select movie_id as v23, v35 from movie_keyword as mk, aggView2560269802861268103 where mk.keyword_id=aggView2560269802861268103.v8;
create or replace view aggView5610041924985792956 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5754745123048872970 as select v23, v35 from aggJoin1813559384612560794 join aggView5610041924985792956 using(v23);
create or replace view aggView2626278158716422986 as select v23, MIN(v35) as v35 from aggJoin5754745123048872970 group by v23;
create or replace view aggJoin4261459623446273208 as select person_id as v14, v35 from cast_info as ci, aggView2626278158716422986 where ci.movie_id=aggView2626278158716422986.v23;
create or replace view aggView335357907786457298 as select v14, MIN(v35) as v35 from aggJoin4261459623446273208 group by v14;
create or replace view aggJoin5956479035787073806 as select name as v15, v35 from name as n, aggView335357907786457298 where n.id=aggView335357907786457298.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin5956479035787073806;
