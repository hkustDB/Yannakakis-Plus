create or replace view semiJoinView8983308587937755593 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView4742302797971562592 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView5624949661617249329 as select v3, v20 from semiJoinView8983308587937755593 where (v20) in (select (id) from company_name AS cn where country_code= '[us]');
create or replace view semiJoinView4668929661334312652 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView5624949661617249329);
create or replace view semiJoinView94828527302528105 as select v26, v3 from semiJoinView4668929661334312652 where (v3) in (select (v3) from semiJoinView4742302797971562592);
create or replace view semiJoinView7209560061165176307 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView94828527302528105);
create or replace view nAux2 as select v27 from semiJoinView7209560061165176307;
select distinct v27 from nAux2;
