create or replace view aggView7633460730195788899 as select id as v14, name as v36 from name as n;
create or replace view aggJoin3880201829637417520 as select movie_id as v23, v36 from cast_info as ci, aggView7633460730195788899 where ci.person_id=aggView7633460730195788899.v14;
create or replace view aggView2866710076114620929 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6521610567633231708 as select movie_id as v23, v35 from movie_keyword as mk, aggView2866710076114620929 where mk.keyword_id=aggView2866710076114620929.v8;
create or replace view aggView4979213426707273182 as select v23, MIN(v36) as v36 from aggJoin3880201829637417520 group by v23;
create or replace view aggJoin7219857323088384674 as select id as v23, title as v24, v36 from title as t, aggView4979213426707273182 where t.id=aggView4979213426707273182.v23 and production_year>2000;
create or replace view aggView883005497623498625 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin7219857323088384674 group by v23;
create or replace view aggJoin521568548415984084 as select v35 as v35, v36, v37 from aggJoin6521610567633231708 join aggView883005497623498625 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin521568548415984084;
