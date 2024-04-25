create or replace view semiJoinView6281739223963216187 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView7458458395536864274 as select id as v14, title as v15, production_year as v18 from title AS t where (id) in (select (v14) from semiJoinView6281739223963216187) and production_year>2005;
create or replace view tAux13 as select v14, v15 from semiJoinView7458458395536864274;
create or replace view semiJoinView4463700562095949883 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'rating') and info>'5.0';
create or replace view mi_idxAux34 as select v14, v9 from semiJoinView4463700562095949883;
create or replace view semiJoinView8167262439222937637 as select distinct v14, v9 from mi_idxAux34 where (v14) in (select (v14) from tAux13);
create or replace view semiEnum6649638131294632218 as select v9, v15 from semiJoinView8167262439222937637 join tAux13 using(v14);
select distinct v9, v15 from semiEnum6649638131294632218;
