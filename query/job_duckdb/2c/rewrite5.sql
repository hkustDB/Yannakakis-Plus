create or replace view aggView1261036182641013811 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin1847729086471563166 as select movie_id as v12 from movie_companies as mc, aggView1261036182641013811 where mc.company_id=aggView1261036182641013811.v1;
create or replace view aggView1273656580400325726 as select v12 from aggJoin1847729086471563166 group by v12;
create or replace view aggJoin3726856752926117996 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView1273656580400325726 where mk.movie_id=aggView1273656580400325726.v12;
create or replace view aggView5725229973293586595 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1973155433088350535 as select v12 from aggJoin3726856752926117996 join aggView5725229973293586595 using(v18);
create or replace view aggView6675695059266538688 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8119200907211240816 as select v31 from aggJoin1973155433088350535 join aggView6675695059266538688 using(v12);
select MIN(v31) as v31 from aggJoin8119200907211240816;
