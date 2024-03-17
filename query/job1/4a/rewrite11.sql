create or replace view aggView7048523130728828335 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin5391728499607947078 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView7048523130728828335 where mk.movie_id=aggView7048523130728828335.v14;
create or replace view aggView8723474486506460521 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7410367862324560441 as select v14, v27 from aggJoin5391728499607947078 join aggView8723474486506460521 using(v3);
create or replace view aggView4996686192967183651 as select v14, MIN(v27) as v27 from aggJoin7410367862324560441 group by v14;
create or replace view aggJoin8968435584778974472 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView4996686192967183651 where mi_idx.movie_id=aggView4996686192967183651.v14 and info>'5.0';
create or replace view aggView2397754177810160263 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin988004354005153659 as select v9, v27 from aggJoin8968435584778974472 join aggView2397754177810160263 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin988004354005153659;
