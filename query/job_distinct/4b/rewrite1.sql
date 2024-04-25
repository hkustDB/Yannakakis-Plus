create or replace view semiJoinView5071823049367928155 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView8177489193419755803 as select id as v14, title as v15, production_year as v18 from title AS t where (id) in (select (v14) from semiJoinView5071823049367928155) and production_year>2010;
create or replace view tAux4 as select v14, v15 from semiJoinView8177489193419755803;
create or replace view semiJoinView5251603185447131942 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'rating');
create or replace view mi_idxAux53 as select v14, v9 from semiJoinView5251603185447131942;
create or replace view semiJoinView8601075873044055035 as select distinct v14, v9 from mi_idxAux53 where (v14) in (select (v14) from tAux4);
create or replace view semiEnum6732876925597133958 as select v9, v15 from semiJoinView8601075873044055035 join tAux4 using(v14);
select distinct v9, v15 from semiEnum6732876925597133958;
