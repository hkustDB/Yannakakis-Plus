create or replace view aggView5605926701239708260 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin5002450739602224840 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView5605926701239708260 where mk.movie_id=aggView5605926701239708260.v14;
create or replace view aggView7773540726960413036 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5945564005150019731 as select v14, v27 from aggJoin5002450739602224840 join aggView7773540726960413036 using(v3);
create or replace view aggView473766554142801555 as select v14, MIN(v27) as v27 from aggJoin5945564005150019731 group by v14;
create or replace view aggJoin5189028593038749633 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView473766554142801555 where mi_idx.movie_id=aggView473766554142801555.v14 and info>'9.0';
create or replace view aggView3961268588233632373 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin5189028593038749633 group by v1;
create or replace view aggJoin7125093846451693084 as select v27, v26 from info_type as it, aggView3961268588233632373 where it.id=aggView3961268588233632373.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7125093846451693084;
