create or replace view aggView2015975401829731484 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6581735680135106507 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView2015975401829731484 where mi_idx.info_type_id=aggView2015975401829731484.v1 and info>'9.0';
create or replace view aggView7210266091421062066 as select v14, COUNT(*) as annot from aggJoin6581735680135106507 group by v14;
create or replace view aggJoin286296613186141235 as select id as v14, production_year as v18, annot from title as t, aggView7210266091421062066 where t.id=aggView7210266091421062066.v14 and production_year>2010;
create or replace view aggView7313061848225317521 as select v14, SUM(annot) as annot from aggJoin286296613186141235 group by v14;
create or replace view aggJoin2694169636803972625 as select keyword_id as v3, annot from movie_keyword as mk, aggView7313061848225317521 where mk.movie_id=aggView7313061848225317521.v14;
create or replace view aggView975142109297326579 as select v3, SUM(annot) as annot from aggJoin2694169636803972625 group by v3;
create or replace view aggJoin4367001576833439806 as select keyword as v4, annot from keyword as k, aggView975142109297326579 where k.id=aggView975142109297326579.v3 and keyword LIKE '%sequel%';
select SUM(annot) as v26 from aggJoin4367001576833439806;
