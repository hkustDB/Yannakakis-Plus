create or replace view semiJoinView7339161850848765914 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView181600344197118473 as select id as v14, title as v15, production_year as v18 from title AS t where (id) in (select (v14) from semiJoinView7339161850848765914) and production_year>2005;
create or replace view tAux13 as select v14, v15 from semiJoinView181600344197118473;
create or replace view semiJoinView7583717645659617696 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'rating') and info>'5.0';
create or replace view mi_idxAux34 as select v14, v9 from semiJoinView7583717645659617696;
create or replace view semiJoinView2584129259993123406 as select distinct v14, v15 from tAux13 where (v14) in (select (v14) from mi_idxAux34);
create or replace view semiEnum6810682880672691025 as select v9, v15 from semiJoinView2584129259993123406 join mi_idxAux34 using(v14);
select distinct v9, v15 from semiEnum6810682880672691025;
