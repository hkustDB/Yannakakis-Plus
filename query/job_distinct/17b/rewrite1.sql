create or replace view semiJoinView7358449662789366107 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView3467646207880133905 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView8143573430524224725 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView2186465067894976470 as select v3, v20 from semiJoinView3467646207880133905 where (v3) in (select (v3) from semiJoinView7358449662789366107);
create or replace view semiJoinView2585294467194648937 as select v26, v3 from semiJoinView8143573430524224725 where (v3) in (select (v3) from semiJoinView2186465067894976470);
create or replace view semiJoinView4486944529524342074 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView2585294467194648937);
create or replace view nAux29 as select v27 from semiJoinView4486944529524342074;
select distinct v27 from nAux29;
