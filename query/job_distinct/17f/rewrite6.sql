create or replace view semiJoinView3207880109529081401 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView2140951342700229507 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView6754685056656859737 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView5314655163951560252 as select v3, v20 from semiJoinView3207880109529081401 where (v3) in (select (v3) from semiJoinView2140951342700229507);
create or replace view semiJoinView3523275640930557897 as select v26, v3 from semiJoinView6754685056656859737 where (v3) in (select (v3) from semiJoinView5314655163951560252);
create or replace view semiJoinView6532735653485015429 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView3523275640930557897);
create or replace view nAux81 as select v27 from semiJoinView6532735653485015429;
select distinct v27 from nAux81;
