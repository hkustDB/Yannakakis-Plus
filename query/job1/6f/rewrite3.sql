create or replace view aggView2980204298045426959 as select id as v14, name as v36 from name as n;
create or replace view aggJoin7534390513709993829 as select movie_id as v23, v36 from cast_info as ci, aggView2980204298045426959 where ci.person_id=aggView2980204298045426959.v14;
create or replace view aggView2356626014569333498 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5859273665934126375 as select v23, v36 from aggJoin7534390513709993829 join aggView2356626014569333498 using(v23);
create or replace view aggView95723930331828690 as select v23, MIN(v36) as v36 from aggJoin5859273665934126375 group by v23;
create or replace view aggJoin5942792439752741641 as select keyword_id as v8, v36 from movie_keyword as mk, aggView95723930331828690 where mk.movie_id=aggView95723930331828690.v23;
create or replace view aggView1043939150787447807 as select v8, MIN(v36) as v36 from aggJoin5942792439752741641 group by v8;
create or replace view aggJoin5306534668449216613 as select keyword as v9, v36 from keyword as k, aggView1043939150787447807 where k.id=aggView1043939150787447807.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5306534668449216613;
