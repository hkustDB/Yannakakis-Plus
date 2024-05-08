create or replace view aggView9089310170601968767 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8240732375066805075 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView9089310170601968767 where mc.movie_id=aggView9089310170601968767.v12;
create or replace view aggView4438976943486352588 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin581148957238843629 as select v12, v31 from aggJoin8240732375066805075 join aggView4438976943486352588 using(v1);
create or replace view aggView3670912844640569794 as select v12, MIN(v31) as v31 from aggJoin581148957238843629 group by v12;
create or replace view aggJoin2153198790620955954 as select keyword_id as v18, v31 from movie_keyword as mk, aggView3670912844640569794 where mk.movie_id=aggView3670912844640569794.v12;
create or replace view aggView1298212289355752534 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin499280395165653912 as select v31 from aggJoin2153198790620955954 join aggView1298212289355752534 using(v18);
select MIN(v31) as v31 from aggJoin499280395165653912;
