create or replace view semiJoinView7489539940998238006 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView4449804849597200632 as select id as v14, title as v15, production_year as v18 from title AS t where (id) in (select (v14) from semiJoinView7489539940998238006) and production_year>1990;
create or replace view semiJoinView6687756126346343813 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'rating');
create or replace view tAux12 as select v14, v15 from semiJoinView4449804849597200632;
create or replace view mi_idxAux1 as select v14, v9 from semiJoinView6687756126346343813;
create or replace view semiJoinView3031630479141604133 as select distinct v14, v9 from mi_idxAux1 where (v14) in (select (v14) from tAux12);
create or replace view semiEnum4588605402534220615 as select v15, v9 from semiJoinView3031630479141604133 join tAux12 using(v14);
select distinct v9, v15 from semiEnum4588605402534220615;
