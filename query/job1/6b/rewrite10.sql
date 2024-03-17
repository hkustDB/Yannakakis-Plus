create or replace view aggView4914406720151495235 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3020537403991317310 as select movie_id as v23, v35 from movie_keyword as mk, aggView4914406720151495235 where mk.keyword_id=aggView4914406720151495235.v8;
create or replace view aggView5840670695475509576 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4876407300308305049 as select movie_id as v23, v36 from cast_info as ci, aggView5840670695475509576 where ci.person_id=aggView5840670695475509576.v14;
create or replace view aggView8402719379349084801 as select v23, MIN(v35) as v35 from aggJoin3020537403991317310 group by v23;
create or replace view aggJoin29616936046123464 as select id as v23, title as v24, v35 from title as t, aggView8402719379349084801 where t.id=aggView8402719379349084801.v23 and production_year>2014;
create or replace view aggView6837997051338027885 as select v23, MIN(v36) as v36 from aggJoin4876407300308305049 group by v23;
create or replace view aggJoin9075939471066361086 as select v24, v35 as v35, v36 from aggJoin29616936046123464 join aggView6837997051338027885 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin9075939471066361086;
