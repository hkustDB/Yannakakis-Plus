create or replace view aggView4294452069684573193 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin7705023062934934203 as select movie_id as v23, v35 from movie_keyword as mk, aggView4294452069684573193 where mk.keyword_id=aggView4294452069684573193.v8;
create or replace view aggView241286004133574551 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin8701098228943928016 as select v23, v35, v37 from aggJoin7705023062934934203 join aggView241286004133574551 using(v23);
create or replace view aggView4445709049009612793 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin8701098228943928016 group by v23;
create or replace view aggJoin227101787126866228 as select person_id as v14, v35, v37 from cast_info as ci, aggView4445709049009612793 where ci.movie_id=aggView4445709049009612793.v23;
create or replace view aggView7995411832394385460 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin227101787126866228 group by v14;
create or replace view aggJoin4626290647698377050 as select name as v15, v35, v37 from name as n, aggView7995411832394385460 where n.id=aggView7995411832394385460.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin4626290647698377050;
