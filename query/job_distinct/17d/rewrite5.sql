create or replace view semiJoinView113385987492852713 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView993670102802116911 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView7777762031873977387 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView3265594028254055158 as select v3, v25 from semiJoinView113385987492852713 where (v3) in (select (v3) from semiJoinView993670102802116911);
create or replace view semiJoinView8431578420075336396 as select v26, v3 from semiJoinView7777762031873977387 where (v3) in (select (v3) from semiJoinView3265594028254055158);
create or replace view semiJoinView5823213280209468719 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView8431578420075336396);
create or replace view nAux74 as select v27 from semiJoinView5823213280209468719;
select distinct v27 from nAux74;
